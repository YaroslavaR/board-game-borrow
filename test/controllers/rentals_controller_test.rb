require 'test_helper'

# Class responsible for rentals testing
class RentalsControllerTest < ActionDispatch::IntegrationTest
# rentals_my_rentals GET    /rentals/my_rentals(.:format)  rentals#my_rentals
#            rentals GET    /rentals(.:format)             rentals#index
#                    POST   /rentals(.:format)             rentals#create
#         new_rental GET    /rentals/new(.:format)         rentals#new
#        edit_rental GET    /rentals/:id/edit(.:format)    rentals#edit
#             rental GET    /rentals/:id(.:format)         rentals#show
#                    PATCH  /rentals/:id(.:format)         rentals#update
#                    PUT    /rentals/:id(.:format)         rentals#update
#                    DELETE /rentals/:id(.:format)         rentals#destroy
    
  setup do
    @rental = rentals(:one)
    @user = users(:three)
    sign_in @user
  end

  test "should get index" do
    get rental_path(@rental.id)
    assert_response :success
  end

  test "should get new" do
    get new_rental_path
    assert_response :success
  end

  test "should show rental" do
    get rental_url(@rental)
    assert_response :success
  end

  test "should get edit" do
    get edit_rental_url(@rental)
    assert_response :success
  end

  test "should edit rental" do
    get edit_rental_url(@rental), params: { rental: { end_time: "2017-03-05", game_id: @rental.game_id, name: @rental.name, start_time: "2017-03-05" } }
    assert_response :success
  end

  test "should destroy rental" do
    assert_difference('Rental.count', -1) do
      delete rental_url(@rental)
    end

    assert_redirected_to rentals_url
  end
end
