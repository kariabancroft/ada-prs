require 'test_helper'

class UserInvitesControllerTest < ActionController::TestCase
  class Unauthenticated < UserInvitesControllerTest
    ACTIONS = {
      index: :get,
      new: :get
    }

    ACTIONS.each do |action, method|
      test "#{action} responds with redirect to root" do
        send(method, action)

        assert_response :redirect
        assert_redirected_to root_path
      end
    end
  end

  class Authenticated < UserInvitesControllerTest
    setup do
      session[:user_id] = users(:instructor).id
    end

    class Index < Authenticated
      test 'responds with success' do
        get :index

        assert_response :ok
      end

      test 'renders appropriate template' do
        get :index

        assert_template 'index'
      end
    end

    class New < Authenticated
      test 'responds with success' do
        get :new

        assert_response :ok
      end

      test 'renders appropriate template' do
        # Initial page with options for student/instructor
        get :new

        assert_template 'new'

        # Student form
        get :new, role: 'student'

        assert_template 'new_student'
      end

      test 'responds 404 with invalid role' do
        get :new, role: 'unknown'

        assert_response :not_found
      end
    end
  end
end
