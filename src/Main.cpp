// Winter 2019

#include <iostream>
#include <string>
#include "scene_lua.hpp"

int main(int argc, char** argv)
{
  int num_workers = 1;
  std::string filename = "Assets/simple.lua";
  if (argc == 2) {
    num_workers = std::atoi(argv[1]);
  } else if (argc == 3) {
    num_workers = std::atoi(argv[1]);
    filename = argv[2];
  }

  if (!run_lua(num_workers, filename)) {
    std::cerr << "Could not open " << filename << std::endl;
    return 1;
  }
}
