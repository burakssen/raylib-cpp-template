#include "App.h"

App::App()
{
    InitWindow(this->m_width, this->m_height, this->m_title.c_str());
    SetTargetFPS(60);
}

App::~App()
{
    CloseWindow();
}

App &App::GetInstance()
{
    static App instance;
    return instance;
}

void App::Run()
{
    while (!WindowShouldClose())
    {
        this->HandleInput();
        this->Update();
        this->Draw();
    }
}

void App::Update()
{
    // Update your game here
}

void App::Draw()
{
    BeginDrawing();
    ClearBackground(RAYWHITE);
    // Draw your game here
    EndDrawing();
}

void App::HandleInput()
{
    // Handle input here
}