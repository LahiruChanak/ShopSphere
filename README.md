
# JavaEE E-Commerce Web Application (ShopSphere)

## 📝 Project Overview
**ShopSphere** is a full-featured e-commerce web application developed using **JavaEE**, **Tomcat JDBC connection pooling**, and **JSP**. This project, created by **Lahiru Kodikara**, demonstrates comprehensive web development skills, focusing on scalability, user-friendly design, and robust functionality.

---

## 🚀 Key Features

### **Core Functionalities**
- **User Authentication**: Secure login and signup with role-based access (Admin/Customer).
- **Role Management**: Admins and customers have distinct capabilities tailored to their roles.

### **Admin Capabilities**
- **Customer Management**: View, search, filter, and manage customer accounts.
- **Product Management**: Add, edit, delete, and view products with advanced search and statistics.
- **Order Management**: Track, filter, and analyze orders with detailed statistics.
- **Category Management**: Manage product categories (add, edit, delete, and view).
- **Profile Management**: Update admin profile information, username, and password.

### **Customer Functionalities**
- **Product Browsing**: Search, filter, and view products with a user-friendly interface.
- **Shopping Cart**: Add, remove, and manage items in the cart.
- **Order Placement**: Place orders seamlessly with a secure checkout process.
- **Order History**: View past orders and track their status.
- **Profile Management**: Update customer profile information, username, and password.

---

## 🛠 Technical Stack
- **Backend**: JavaEE, Servlets
- **Database**: MySQL
- **Connection Pooling**: Tomcat JDBC connection pooling
- **Frontend**: JSP, CSS, JavaScript
- **Optional Enhancements**: Bootstrap for responsive UI, jQuery for dynamic interactions.

---

## 📦 Database Schema
The database is designed to support all functionalities of the application. Key tables include:
- `products`: Stores product details.
- `categories`: Manages product categories.
- `users`: Handles user information and roles.
- `orders`: Tracks customer orders.
- `order_details`: Stores details of each order.
- `cart`: Manages customer shopping carts.
- `cart_details`: Tracks items in the cart.

---

## 🔧 Setup Instructions

### **Prerequisites**
- Java Development Kit (JDK) 17+
- Apache Tomcat 10.1.x
- MySQL Database

### **Installation Steps**
1. Clone the repository:
   ```bash
   git clone https://github.com/LahiruChanak/ShopSphere.git
   ```
2. Navigate to the project directory:
   ```bash
   cd ShopSphere
   ```
3. Import the project into your IDE and reload the `pom.xml` file.
4. Configure the database connection in `src/main/webapp/META-INF/context.xml`.
5. Deploy the application on the Tomcat server.
6. Run the application and access it via your browser.

---

## 🖼 Application Screenshots

### **Authentication Pages**
| **Login Page** | **Signup Page** | **Reset Password Page** | **Admin Login Page** |
|----------------|-----------------|-------------------------|----------------------|
| ![Login Page](https://github.com/LahiruChanak/ShopSphere/blob/master/src/main/webapp/assets/images/readme/001.png?raw=true) | ![Signup Page](https://github.com/LahiruChanak/ShopSphere/blob/master/src/main/webapp/assets/images/readme/002.png?raw=true) | ![Reset Password Page](https://github.com/LahiruChanak/ShopSphere/blob/master/src/main/webapp/assets/images/readme/003.png?raw=true) | ![Admin Login Page](https://github.com/LahiruChanak/ShopSphere/blob/master/src/main/webapp/assets/images/readme/004.png?raw=true) |

### **Customer Pages**
| **Customer Homepage** | **Customer Profile** | **Search Page** |
|-----------------------|----------------------|-----------------|
| ![Customer Homepage](https://github.com/LahiruChanak/ShopSphere/blob/master/src/main/webapp/assets/images/readme/005.png?raw=true) | ![Customer Profile](https://github.com/LahiruChanak/ShopSphere/blob/master/src/main/webapp/assets/images/readme/006.png?raw=true) | ![Search Page](https://github.com/LahiruChanak/ShopSphere/blob/master/src/main/webapp/assets/images/readme/007.png?raw=true) |

### **Admin Pages**
| **Category Management** | **Products Management** | **User Management** | **Order Management** |
|-------------------------|-------------------------|---------------------|----------------------|
| ![Categories Management](https://github.com/LahiruChanak/ShopSphere/blob/master/src/main/webapp/assets/images/readme/008.png?raw=true) | ![Products Management](https://github.com/LahiruChanak/ShopSphere/blob/master/src/main/webapp/assets/images/readme/009.png?raw=true) | ![User Management](https://github.com/LahiruChanak/ShopSphere/blob/master/src/main/webapp/assets/images/readme/010.png?raw=true) | ![Order Management](https://github.com/LahiruChanak/ShopSphere/blob/master/src/main/webapp/assets/images/readme/011.png?raw=true) |

### **Shopping & Order Pages**
| **Product Page** | **Shopping Cart** | **Order Page** | **Payment Page** |
|------------------|-------------------|----------------|------------------|
| ![Product Page](https://github.com/LahiruChanak/ShopSphere/blob/master/src/main/webapp/assets/images/readme/012.png?raw=true) | ![Shopping Cart](https://github.com/LahiruChanak/ShopSphere/blob/master/src/main/webapp/assets/images/readme/013.png?raw=true) | ![Order Page](https://github.com/LahiruChanak/ShopSphere/blob/master/src/main/webapp/assets/images/readme/014.png?raw=true) | ![Payment Page](https://github.com/LahiruChanak/ShopSphere/blob/master/src/main/webapp/assets/images/readme/015.png?raw=true) |

---

## 🎥 Demo Video
A demo video showcasing the application's features is available on YouTube:  
[YouTube Demo Link](#) *(Replace with your actual link)*

---

## 🌟 Bonus Features
- **Advanced Product Search**: Filter products by category, price range, and ratings.
- **User Role Management**: Admins can manage user roles and permissions.
- **AJAX-Powered Interactions**: Dynamic updates for cart, search, and order placement.

---

## 👥 Contributors
- **Lahiru Kodikara** - Project Developer  
  [GitHub Profile](https://github.com/LahiruChanak)

---

**Project URL**: [https://github.com/LahiruChanak/ShopSphere.git](https://github.com/LahiruChanak/ShopSphere.git) 

**Branch**: `master`
