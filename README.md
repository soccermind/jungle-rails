# Jungle Project

A mini e-commerce application built with Rails 4.2 for purposes of teaching Ruby on Rails by example. Testing was done using RSpec.
Users can view list of products and filter by category, view product details, add items to cart, view cart, edit item quantity in cart, pay with credit card (using Stripe) and view order details. 
User can also register with their email and password (optional).
Admin users can view a Dashboard with general stats, create new products, delete products, and create new categories. Access is restricted using HTTP Basic Authentication. 

## Final Product
!["Home display"](https://github.com/soccermind/jungle-rails/blob/master/docs/AllProducts.png)
!["My cart"](https://github.com/soccermind/jungle-rails/blob/master/docs/MyCart.png)
!["Payment info"](https://github.com/soccermind/jungle-rails/blob/master/docs/PayWithCard.png)
!["Order details"](https://github.com/soccermind/jungle-rails/blob/master/docs/OrderDetails.png)


## Setup

1. Run `bundle install` to install dependencies
2. Create `config/database.yml` by copying `config/database.example.yml`
3. Create `config/secrets.yml` by copying `config/secrets.example.yml`
4. Run `bin/rake db:reset` to create, load and seed db
5. Create .env file based on .env.example
6. Sign up for a Stripe account
7. Put Stripe (test) keys into appropriate .env vars
8. Run `bin/rails s -b 0.0.0.0` to start the server

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* Stripe
