#include <memory>

#include "rclcpp/rclcpp.hpp"
#include "geometry_msgs/msg/pose_with_covariance_stamped.hpp"
using std::placeholders::_1;

#include "matplotlibcpp.h"
namespace plt = matplotlibcpp;

class ViveTrackerSubscriber : public rclcpp::Node
{
  public:
    ViveTrackerSubscriber()
    : Node("vive_tracker_subscriber"), pose_({0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0})
    {
      subscription_ = this->create_subscription<geometry_msgs::msg::PoseWithCovarianceStamped>(
      "/vive/LHR_6A0410E7_pose", 10, std::bind(&ViveTrackerSubscriber::topic_callback, this, _1));
    }

    void plot_3d_data()
    {
      std::map<std::string, std::string> keywords;
      keywords.insert(std::pair<std::string, std::string>("label", "pose path") );

      plt::plot3(x_, y_, z_, keywords);
      plt::xlabel("x label");
      plt::ylabel("y label");
      plt::set_zlabel("z label"); // set_zlabel rather than just zlabel, in accordance with the Axes3D method
      plt::legend();
      plt::show();
      plt::pause(1);
    }

  private:
    void topic_callback(const geometry_msgs::msg::PoseWithCovarianceStamped::SharedPtr msg)
    {
      pose_[0] = msg->pose.pose.position.x;
      pose_[1] = msg->pose.pose.position.y;
      pose_[2] = msg->pose.pose.position.z;
      pose_[3] = msg->pose.pose.orientation.x;
      pose_[4] = msg->pose.pose.orientation.y;
      pose_[5] = msg->pose.pose.orientation.z;
      pose_[6] = msg->pose.pose.orientation.w;

      x_.push_back(pose_[0]);
      y_.push_back(pose_[1]);
      z_.push_back(pose_[2]);

      RCLCPP_INFO(this->get_logger(), "Subscribed to data once.");
      plot_3d_data();
    }
    rclcpp::Subscription<geometry_msgs::msg::PoseWithCovarianceStamped>::SharedPtr subscription_;
    std::vector<double> pose_;
    std::vector<double> x_, y_, z_;
};

int main(int argc, char * argv[])
{
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<ViveTrackerSubscriber>());
  rclcpp::shutdown();
  return 0;
}