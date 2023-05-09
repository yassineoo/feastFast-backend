//const prisma = require('../prisma/dbConnection');

// Create a new User
async function createUser(data) {
     try {
          const result = await prisma.users.create({
               ...req.body,
          });
          return result;
     } catch (error) {
          console.error(error);
          throw new Error('Error creating User');
     }
}

// Read a User by id
const getUserById = async (req, res) => {
     try {
          const { id } = req.params;
          const result = await prisma.users.findUnique({
               where: { id: Number(id) },
          });
          return res.status(200).json(result);
     } catch (error) {
          console.error(error);
          // throw new Error('Error getting User by id');
     }
};

// Update a User
const updateUser = async (req, res) => {
     try {
          const { id } = req.params;

          const result = await prisma.users.update({
               where: { id: Number(id) },
               data: { ...req.body },
          });
          return result;
     } catch (error) {
          console.error(error);
          throw new Error('Error updating User');
     }
};

// Delete a User
const deleteUser = async (req, res) => {
     try {
          const { id } = req.params;
          const result = await prisma.users.delete({
               where: { id: Number(id) },
          });
          return result;
     } catch (error) {
          console.error(error);
          throw new Error('Error deleting User');
     }
};

module.exports = { createUser, getUserById, updateUser, deleteUser };
