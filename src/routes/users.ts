import { Router } from 'express';
import prisma from '../prisma';

const router = Router();

router.get('/', async (req, res) => {
  const users = await prisma.user.findMany();
  res.status(200).json(users);
});

router.post('/', async (req, res, next) => {
  const { name, email } = req.body;

  try {
    const newUser = await prisma.user.create({
      data: {
        name,
        email,
      },
    });

    res.status(201).json(newUser);
  } catch (error) {
    res.status(400);
    next(error);
  }
});

export default router;
