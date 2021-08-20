cmake_minimum_required(VERSION 3.5)
project(vive_tracker_analysis)

# Default to C99
if(NOT CMAKE_C_STANDARD)
  set(CMAKE_C_STANDARD 99)
endif()

# Default to C++14
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# find dependencies
find_package(ament_cmake REQUIRED)
# uncomment the following section in order to fill in
# further dependencies manually.
# find_package(<dependency> REQUIRED)
find_package(rclcpp REQUIRED)
find_package(geometry_msgs REQUIRED)

#set(Python_INCLUDE_DIRS "/usr/include/python3.8" CACHE PATH "header directory")
#set(Python_LIBRARIES "/usr/lib/x86_64-linux-gnu/libpython3.8.so" CACHE FILEPATH "python library location")

find_package (Python COMPONENTS Interpreter Development NumPy REQUIRED)
message("Python_FOUND:${Python_FOUND}")
message("Python_VERSION:${Python_VERSION}")
message("Python_Development_FOUND:${Python_Development_FOUND}")
message("Python_NumPy_FOUND:${Python_NumPy_FOUND}")
message("Python_LIBRARIES:${Python_LIBRARIES}")
message("Python_LIBRARY_DIRS:${Python_LIBRARY_DIRS}")
message("Python_DIRS:${Python_INCLUDE_DIRS}")

find_path(MATPLOTLIB_CPP_INCLUDE_DIRS "matplotlibcpp.h")

add_executable(subscriber src/vive_subscriber_3d_visualiser.cpp)
ament_target_dependencies(subscriber rclcpp geometry_msgs Python)
target_include_directories(subscriber PRIVATE ${Python_INCLUDE_DIRS} ${MATPLOTLIB_CPP_INCLUDE_DIRS})
#target_link_libraries(subscriber PRIVATE ${Python_LIBRARIES})  # replaced by ament_target_dependencies(subscriber Python)

install(TARGETS
  subscriber
  DESTINATION lib/${PROJECT_NAME})

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  # the following line skips the linter which checks for copyrights
  # uncomment the line when a copyright and license is not present in all source files
  #set(ament_cmake_copyright_FOUND TRUE)
  # the following line skips cpplint (only works in a git repo)
  # uncomment the line when this package is not in a git repo
  #set(ament_cmake_cpplint_FOUND TRUE)
  ament_lint_auto_find_test_dependencies()
endif()

ament_package()