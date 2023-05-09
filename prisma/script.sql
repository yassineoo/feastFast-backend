CREATE DATABASE feastFast;

USE feastFast;

CREATE TABLE Users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  phone_number VARCHAR(20) UNIQUE NOT NULL,
  address VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  latitude FLOAT,
  longitude FLOAT,
  profile_picture VARCHAR(255),
  registration_type ENUM('Native', 'Facebook', 'Google') NOT NULL,
  social_media_id VARCHAR(255)
);

CREATE TABLE Restaurants (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  picture VARCHAR(255) NOT NULL,
  logo VARCHAR(255),
  locationAddress VARCHAR(255) NOT NULL,
  locationMapLat FLOAT,
  locationMaplong FLOAT,
  cuisineType VARCHAR(255) NOT NULL,
  phoneNumber VARCHAR(20),
  averageRating FLOAT,
  email VARCHAR(255),
  instaLink VARCHAR(255),
  fbLink VARCHAR(255)
);

CREATE TABLE Ratings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  restaurant_id INT NOT NULL,
  rating INT NOT NULL,
  review TEXT,
  created_at DATETIME NOT NULL,
  FOREIGN KEY (user_id) REFERENCES Users(id),
  FOREIGN KEY (restaurant_id) REFERENCES Restaurants(id)
);

CREATE TABLE MenuItems (
  id INT AUTO_INCREMENT PRIMARY KEY,
  restaurant_id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL,
  image VARCHAR(255),
  FOREIGN KEY (restaurant_id) REFERENCES Restaurants(id)
);

CREATE TABLE Orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  restaurant_id INT NOT NULL,
  delivery_address VARCHAR(255) NOT NULL,
  delivery_notes TEXT,
  order_status ENUM('Pending', 'Preparing', 'Picked Up', 'Delivered') NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  FOREIGN KEY (user_id) REFERENCES Users(id),
  FOREIGN KEY (restaurant_id) REFERENCES Restaurants(id)
);

CREATE TABLE OrderItems (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  menu_item_id INT NOT NULL,
  quantity INT NOT NULL,
  special_instructions TEXT,
  FOREIGN KEY (order_id) REFERENCES Orders(id),
  FOREIGN KEY (menu_item_id) REFERENCES MenuItems(id)
);

CREATE TABLE Notifications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  order_id INT NOT NULL,
  notification_type ENUM('Preparing', 'Picked Up', 'On the Way') NOT NULL,
  sent_at DATETIME NOT NULL,
  FOREIGN KEY (user_id) REFERENCES Users(id),
  FOREIGN KEY (order_id) REFERENCES Orders(id)
);



INSERT INTO Restaurants (name, picture, logo, locationAddress, locationMapLat, locationMaplong, cuisineType, phoneNumber, averageRating, email, instaLink, fbLink) VALUES 
("Taco Haven", "taco-haven.jpg", "taco-haven-logo.png", "789 Oak Street", 34.0522, -118.2437, "Mexican", "(555) 555-9012", 3.5, "info@tacohaven.com", "https://instagram.com/tacohaven", "https://facebook.com/tacohaven");

INSERT INTO Restaurants (name, picture, logo, locationAddress, locationMapLat, locationMaplong, cuisineType, phoneNumber, averageRating, email, instaLink, fbLink) VALUES 
("Pizza Palace", "pizza-palace.jpg", "pizza-palace-logo.png", "234 Maple Street", 34.0522, -118.2437, "Italian", "(555) 555-3456", 4.2, "info@pizzapalace.com", "https://instagram.com/pizzapalace", "https://facebook.com/pizzapalace");

INSERT INTO Restaurants (name, picture, logo, locationAddress, locationMapLat, locationMaplong, cuisineType, phoneNumber, averageRating, email, instaLink, fbLink) VALUES 
("Pho House", "pho-house.jpg", "pho-house-logo.png", "567 Walnut Street", 34.0522, -118.2437, "Vietnamese", "(555) 555-6789", 4.8, "info@phohouse.com", "https://instagram.com/phohouse", "https://facebook.com/phohouse");

