require 'test_helper'

class TimeTracksControllerTest < ActionController::TestCase
  setup do
    @time_track = time_tracks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:time_tracks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create time_track" do
    assert_difference('TimeTrack.count') do
      post :create, time_track: { date: @time_track.date, project_id: @time_track.project_id, resource_id: @time_track.resource_id, status: @time_track.status, user_id: @time_track.user_id }
    end

    assert_redirected_to time_track_path(assigns(:time_track))
  end

  test "should show time_track" do
    get :show, id: @time_track
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @time_track
    assert_response :success
  end

  test "should update time_track" do
    patch :update, id: @time_track, time_track: { date: @time_track.date, project_id: @time_track.project_id, resource_id: @time_track.resource_id, status: @time_track.status, user_id: @time_track.user_id }
    assert_redirected_to time_track_path(assigns(:time_track))
  end

  test "should destroy time_track" do
    assert_difference('TimeTrack.count', -1) do
      delete :destroy, id: @time_track
    end

    assert_redirected_to time_tracks_path
  end
end
