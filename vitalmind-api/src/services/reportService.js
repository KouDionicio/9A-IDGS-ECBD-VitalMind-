const ExcelJS = require('exceljs');
const PDFDocument = require('pdfkit');
const { Parser: CsvParser } = require('json2csv');
const ApiError = require('../utils/ApiError');

const userRepository = require('../repositories/userRepository');
const medicationRepository = require('../repositories/medicationRepository');
const appointmentRepository = require('../repositories/appointmentRepository');
const symptomLogRepository = require('../repositories/symptomLogRepository');
const medicalHistoryRepository = require('../repositories/medicalHistoryRepository');

/** Fuentes de datos exportables. Cada una regresa un array plano de objetos. */
const DATA_SOURCES = {
  users: async (filters) => (await userRepository.findAll({ ...filters, limit: 1000, offset: 0 })).rows,
  medications: async (filters) => (await medicationRepository.findAll({ ...filters, limit: 1000, offset: 0 })).rows,
  appointments: async (filters) => (await appointmentRepository.findAll({ ...filters, limit: 1000, offset: 0 })).rows,
  symptoms: async (filters) => (await symptomLogRepository.findAll({ ...filters, limit: 1000, offset: 0 })).rows,
  medicalHistory: async (filters) => (await medicalHistoryRepository.findAll({ ...filters, limit: 1000, offset: 0 })).rows,
};

async function getData(entity, filters) {
  const loader = DATA_SOURCES[entity];
  if (!loader) {
    throw ApiError.badRequest(
      `Entidad de reporte inválida: "${entity}". Use una de: ${Object.keys(DATA_SOURCES).join(', ')}`
    );
  }
  const rows = await loader(filters);
  if (!rows.length) return [];
  return rows;
}

async function toCsv(entity, filters) {
  const rows = await getData(entity, filters);
  if (!rows.length) return '';
  const parser = new CsvParser({ fields: Object.keys(rows[0]) });
  return parser.parse(rows);
}

async function toExcel(entity, filters) {
  const rows = await getData(entity, filters);
  const workbook = new ExcelJS.Workbook();
  workbook.creator = 'VitalMind API';
  workbook.created = new Date();

  const sheet = workbook.addWorksheet(entity);
  if (rows.length) {
    sheet.columns = Object.keys(rows[0]).map((key) => ({ header: key, key, width: 22 }));
    sheet.getRow(1).font = { bold: true };
    rows.forEach((row) => sheet.addRow(row));
  } else {
    sheet.addRow(['Sin datos para los filtros aplicados']);
  }

  return workbook.xlsx.writeBuffer();
}

function toPdf(entity, filters) {
  return new Promise(async (resolve, reject) => {
    try {
      const rows = await getData(entity, filters);
      const doc = new PDFDocument({ margin: 40, size: 'A4', layout: 'landscape' });
      const chunks = [];
      doc.on('data', (chunk) => chunks.push(chunk));
      doc.on('end', () => resolve(Buffer.concat(chunks)));
      doc.on('error', reject);

      doc.fontSize(18).text(`Reporte VitalMind IA — ${entity}`, { align: 'left' });
      doc.moveDown(0.3);
      doc.fontSize(9).fillColor('gray').text(`Generado: ${new Date().toLocaleString('es-MX')}`);
      doc.moveDown(1);
      doc.fillColor('black');

      if (!rows.length) {
        doc.fontSize(12).text('Sin datos para los filtros aplicados.');
        doc.end();
        return;
      }

      const columns = Object.keys(rows[0]);
      const colWidth = Math.max(60, Math.floor((doc.page.width - 80) / columns.length));
      let y = doc.y;

      doc.fontSize(8).font('Helvetica-Bold');
      columns.forEach((col, i) => {
        doc.text(String(col), 40 + i * colWidth, y, { width: colWidth, ellipsis: true });
      });
      y += 16;
      doc.moveTo(40, y).lineTo(doc.page.width - 40, y).strokeColor('#cccccc').stroke();
      y += 4;

      doc.font('Helvetica').fontSize(7.5);
      rows.forEach((row) => {
        if (y > doc.page.height - 50) {
          doc.addPage();
          y = 40;
        }
        columns.forEach((col, i) => {
          const value = row[col] === null || row[col] === undefined ? '' : String(row[col]);
          doc.text(value, 40 + i * colWidth, y, { width: colWidth, ellipsis: true });
        });
        y += 14;
      });

      doc.end();
    } catch (err) {
      reject(err);
    }
  });
}

module.exports = { getData, toCsv, toExcel, toPdf, DATA_SOURCES };
