const { id } = require('date-fns/locale');
const prisma = require('../prisma/dbConnection');
// Controller function to get all restaurants
const getAllRestaurants = async (req, response) => {
	try {
	  const idUser = Number(req.params.idUser);
	  let restaurants = [];
	  let preferredRestaurantIds = [];
  
	  // Fetch preferred restaurants for the user
	  if (idUser) {
		const preferredRestaurants = await prisma.prefer_restaurant.findMany({
		  where: {
			user_id: idUser,
		  },
		  select: {
			restaurant_id: true,
		  },
		});
  
		// Get the IDs of the preferred restaurants
		preferredRestaurantIds = preferredRestaurants.map(
		  (restaurant) => restaurant.restaurant_id
		);
	  }
  
	  // Fetch all restaurants
	  restaurants = await prisma.restaurants.findMany();
  
	  // Add a new attribute indicating if the restaurant is preferred by the user
	  const allInfoRestaurants = await Promise.all(
		restaurants.map(async (restaurant) => {
		  const resInfo = await getAverageRatingAndRatersCount(restaurant.id);
  
		  const reslt = {
			...restaurant,
			isPreferred: preferredRestaurantIds.includes(restaurant.id),
			averageRating: resInfo?.averageRating,
			ratersCount: resInfo?.totalRaters,
		  };
  
		  return reslt;
		})
	  );
  
	  // Sort the restaurants by average rating from highest to lowest
	  const sortedRestaurants = allInfoRestaurants.sort(
		(a, b) => b.averageRating - a.averageRating
	  );
  
	  return response.status(200).json(sortedRestaurants);
	} catch (err) {
	  response.status(500).json({ error: err.message });
	}
  };

const getAllRestaurantsTopRaters = async (req, response) => {
	try {
	  const idUser = Number(req.params.idUser);
	  let restaurants = [];
	  let preferredRestaurantIds = [];
  
	  // Fetch preferred restaurants for the user
	  if (idUser) {
		const preferredRestaurants = await prisma.prefer_restaurant.findMany({
		  where: {
			user_id: idUser,
		  },
		  select: {
			restaurant_id: true,
		  },
		});
  
		// Get the IDs of the preferred restaurants
		preferredRestaurantIds = preferredRestaurants.map(
		  (restaurant) => restaurant.restaurant_id
		);
	  }
  
	  // Fetch all restaurants
	  restaurants = await prisma.restaurants.findMany();
  
	  // Add a new attribute indicating if the restaurant is preferred by the user
	  const allInfoRestaurants = await Promise.all(
		restaurants.map(async (restaurant) => {
		  const resInfo = await getAverageRatingAndRatersCount(restaurant.id);
  
		  const reslt = {
			...restaurant,
			isPreferred: preferredRestaurantIds.includes(restaurant.id),
			averageRating: resInfo?.averageRating,
			ratersCount: resInfo?.totalRaters,
		  };
  
		  return reslt;
		})
	  );
  
	  // Sort the restaurants by average rating from highest to lowest
	  const sortedRestaurants = allInfoRestaurants.sort(
		(a, b) => b.totalRaters - a.totalRaters
	  );
  
	  return response.status(200).json(sortedRestaurants);
	} catch (err) {
	  response.status(500).json({ error: err.message });
	}
  };
  

const getFavriteRestaurants = async (req, res) => {
	try {
		const idUser = Number(req.params.idUser);

		// Fetch preferred restaurant IDs for the user
		const preferredRestaurantIds =
			await prisma.prefer_restaurant.findMany({
				where: {
					user_id: idUser,
				},
				select: {
					restaurant_id: true,
				},
			});

		// Extract the restaurant IDs from the fetched results
		const restaurantIds = preferredRestaurantIds.map(
			(item) => item.restaurant_id
		);

		// Fetch restaurant details for the extracted IDs
		let preferredRestaurants = await prisma.restaurants.findMany({
			where: {
				id: {
					in: restaurantIds,
				},
			},
		});
		preferredRestaurants = preferredRestaurants.map((restaurant) => ({
			...restaurant,
			isPreferred: true,
		}));

		res.status(200).json(preferredRestaurants);
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
};

// Controller function to get a specific restaurant by ID
const getRestaurantById = async (req, res) => {
	try {
		const { idUser,idRes } = req.params;
		
		const restaurant = await prisma.restaurants.findUnique({
			where: {
				id: Number(idRes),
			},
		});
		let favorite = null;
		if (idUser) {
		 favorite = await prisma.prefer_restaurant.findFirst({
			where: {
				user_id: Number(idUser),
				restaurant_id : Number(idRes)
			}
		});

	}

		if (!restaurant) {
			// Handle the case when the restaurant doesn't exist
			return res.status(404).json({ error: 'Restaurant not found' });
		}

		const resInfo = await getAverageRatingAndRatersCount(idRes);
		const restaurantWithMenu = {
			...restaurant,
			isPreferred: favorite ? true:false,
			averageRating: resInfo?.averageRating ,
			ratersCount: resInfo?.totalRaters ,
			
		};

		res.status(200).json(restaurantWithMenu);
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
};

// Controller function to get a specific restaurant Menu by ID
const getRestaurantMenuById = async (req, res) => {
	try {
		const { id } = req.params;
		const restaurant = await prisma.menuitems.findMany({
			where: { restaurant_id: parseInt(id) },
		});
		if (!restaurant) {
			return res
				.status(404)
				.json({ error: `Restaurant with ID ${id} not found` });
		}
		return res.status(200).json(restaurant);
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
};




// Controller function to get ratings for a specific restaurant
const getRatingsByRestaurantId = async (req, res) => {
	try {
	  const { id } = req.params;
	  
	  // Fetch ratings for the restaurant
	  const ratings = await prisma.ratings.findMany({
		where: {
		  restaurant_id: parseInt(id),
		},
	  });
  
	  res.status(200).json(ratings);
	} catch (err) {
	  res.status(500).json({ error: err.message });
	}
  };
  
  // Controller function to add a rating for a restaurant
  const addRating = async (req, res) => {
	try {
	  const { restaurantId, userId, rating, review } = req.body;
  
	  // Create a new rating entry
	  const newRating = await prisma.ratings.create({
		data: {
		  restaurant_id: restaurantId,
		  user_id: userId,
		  rating: rating,
		  review: review,
		  created_at: new Date(),
		},
	  });
  
	  res.status(201).json(newRating);
	} catch (err) {
	  res.status(500).json({ error: err.message });
	}
  };


  async function getRatingDistribution(req,res) {
	try {
				const { id } = req.params;
	  const ratings = await prisma.ratings.findMany({
		where: {
		  restaurant_id: parseInt(id),
		},
	  });
	  const ratingDistribution = [0, 0, 0, 0, 0]; // Initialize the array with zeros for each rating count
      console.log(ratings);
	  ratings.forEach((rating) => {
		if (rating.rating == 5) {
		  ratingDistribution[0] += 1; // Increment count for 5-star rating
		} else if (rating.rating == 4) {
		  ratingDistribution[1] += 1; // Increment count for 4-star rating
		} else if (rating.rating == 3) {
		  ratingDistribution[2] += 1; // Increment count for 3-star rating
		} else if (rating.rating == 2) {
		  ratingDistribution[3] += 1; // Increment count for 2-star rating
		} else if (rating.rating == 1) {
		  ratingDistribution[4] += 1; // Increment count for 1-star rating
		}
	  });
  
	  return res.status(200).json( ratingDistribution);
	} catch (error) {
		return res.status(500).json({ error: error.message })
	  console.error('Error retrieving rating distribution:', error);
	  throw error;
	}
  }

  async function getAverageRatingAndRatersCount(restaurantId) {
	const ratings = await prisma.ratings.findMany({
	  where: {
		restaurant_id:Number (restaurantId),
	  },
	});
  
	const totalRaters = ratings.length;
	const sumRatings = ratings.reduce((sum, rating) => sum + rating.rating, 0);
	const averageRating = totalRaters > 0 ? sumRatings / totalRaters : 0;
  
	return { averageRating, totalRaters };
  }
module.exports = {
	getAllRestaurants,
	getRestaurantById,
	getRestaurantMenuById,
	getFavriteRestaurants,
	getRatingDistribution,
	addRating
};
