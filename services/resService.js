const prisma = require('../prisma/dbConnection');
const getAllRestaurants = async (idUser) => {
    let restaurants = [];
	
    // Fetch all restaurants
    restaurants = await prisma.restaurants.findMany();
    let preferredRestaurantIds = [];
    if (idUser) {
    // Fetch preferred restaurants for the user
    const preferredRestaurants =
        await prisma.prefer_restaurant.findMany({
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

    // Fetch all restaurants and mark them as preferred or not
    restaurants = await prisma.restaurants.findMany();

    // Add a new attribute indicating if the restaurant is preferred by the user
    const allInforestaurants = await Promise.all(restaurants.map(async (restaurant) => {
        const resInfo = await getAverageRatingAndRatersCount(restaurant.id);
      
        const reslt = {
          ...restaurant,
          isPreferred: preferredRestaurantIds.includes(restaurant.id),
          averageRating: resInfo?.averageRating ,
          ratersCount: resInfo?.totalRaters ,
        };
      
        return reslt;
      }));
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

module.exports = {getAllRestaurants}