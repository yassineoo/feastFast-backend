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



INSERT INTO Users (name, email, phone_number, address, password, latitude, longitude, profile_picture, registration_type, social_media_id)
VALUES
  ('John Doe', 'john.doe@example.com', '1234567890', '123 Main St, Anytown, USA', 'mypassword', 40.7128, -74.0060, 'profile-pic.jpg', 'Native', NULL),
  ('Jane Smith', 'jane.smith@example.com', '0987654321', '456 Elm St, Anytown, USA', 'anotherpassword', 37.7749, -122.4194, 'profile-pic.png', 'Facebook', '123456'),
  ('Bob Johnson', 'bob.johnson@example.com', '5555555555', '789 Oak St, Anytown, USA', 'yetanotherpassword', 51.5074, -0.1278, NULL, 'Google', '789012');

INSERT INTO Ratings (user_id, restaurant_id, rating, review, created_at)
VALUES (1, 1, 4, 'Great food and atmosphere!', '2023-05-09 10:30:00');

select * from MenuItems ;
INSERT INTO MenuItems (restaurant_id, name, description, price, image)
VALUES (1, 'French Fries', 'Thin, crispy french fries with sea salt', 4.99, 'https://example.com/images/fries.jpg');

INSERT INTO MenuItems (restaurant_id, name, description, price, image)
VALUES (1, 'Chicken Wings', 'Spicy buffalo chicken wings with blue cheese dip', 12.99, 'https://example.com/images/wings.jpg');

INSERT INTO MenuItems (restaurant_id, name, description, price, image)
VALUES (2, 'Margherita Pizza', 'Classic Neapolitan-style pizza with tomato sauce, mozzarella, and fresh basil', 14.99, 'https://example.com/images/pizza.jpg');

INSERT INTO MenuItems (restaurant_id, name, description, price, image)
VALUES (2, 'Caesar Salad', 'Crisp romaine lettuce with parmesan cheese, croutons, and classic Caesar dressing', 8.99, 'https://example.com/images/salad.jpg');


INSERT INTO Orders (user_id, restaurant_id, delivery_address, delivery_notes, order_status, created_at, updated_at)
VALUES 
  (1, 1, '123 Main St', 'Ring buzzer for delivery', 'Pending', NOW(), NOW()),
  (2, 3, '456 Elm St', '', 'Preparing', NOW(), NOW());
  
INSERT INTO OrderItems (order_id, menu_item_id, quantity, special_instructions) VALUES
(11, 1, 2, 'No onions please'),
(11, 4, 1, 'Extra cheese');