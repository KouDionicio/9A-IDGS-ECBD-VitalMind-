import { Router } from "express";
import { authRequired } from "../middlewares/auth.js";
import { login, me, register } from "../controllers/auth.controller.js";

export const authRouter = Router();

authRouter.post("/register", register);
authRouter.post("/login", login);
authRouter.get("/me", authRequired, me);