const asyncHandler = require('../utils/asyncHandler');
const reportService = require('../services/reportService');

const exportCsv = asyncHandler(async (req, res) => {
  const { entity } = req.params;
  const csv = await reportService.toCsv(entity, req.query);
  res.setHeader('Content-Type', 'text/csv; charset=utf-8');
  res.setHeader('Content-Disposition', `attachment; filename="${entity}.csv"`);
  res.send(csv || 'Sin datos');
});

const exportExcel = asyncHandler(async (req, res) => {
  const { entity } = req.params;
  const buffer = await reportService.toExcel(entity, req.query);
  res.setHeader(
    'Content-Type',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  );
  res.setHeader('Content-Disposition', `attachment; filename="${entity}.xlsx"`);
  res.send(buffer);
});

const exportPdf = asyncHandler(async (req, res) => {
  const { entity } = req.params;
  const buffer = await reportService.toPdf(entity, req.query);
  res.setHeader('Content-Type', 'application/pdf');
  res.setHeader('Content-Disposition', `attachment; filename="${entity}.pdf"`);
  res.send(buffer);
});

module.exports = { exportCsv, exportExcel, exportPdf };
