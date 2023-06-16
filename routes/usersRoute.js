const express = require('express');
const router = express.Router();

const userController = require('../controllers/usersController');

// Get user by id
router.get('/:id', userController.getUserById);

// Create new user
router.post('/register', userController.sighUp);
// login
router.post('/login', userController.login);
// Update user by id
router.post('/edit', userController.updateUser);

// Delete user by id
router.delete('/:id', userController.deleteUser);

// like or disLike
router.post('/:iduser/:idres', userController.favoriteRestaurant);

module.exports = router;
