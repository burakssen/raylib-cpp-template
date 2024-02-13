#pragma once

// system headers
#include <string>

// raylib headers
#include <raylib.h>

// project headers

class App
{
    App();

public:
    ~App();
    static App &GetInstance();
    void Run();

private:
    void Update();
    void Draw();
    void HandleInput();

private:
    float m_width = 1024;
    float m_height = 768;

    std::string m_title = "Raylib Template";
};