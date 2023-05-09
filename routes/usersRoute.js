const express = require('express');
const router = express.Router();

const userController = require('../controllers/usersController');

// Get user by id
router.get('/:id', userController.getUserById);

// Create new user
router.post('/', userController.createUser);

// Update user by id
router.put('/:id', userController.updateUser);

// Delete user by id
router.delete('/:id', userController.deleteUser);

module.exports = router;
