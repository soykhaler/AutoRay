#!/usr/bin/env bash
set -e



echo "1. Actualizando repositorios e instalando dependencias..."
sudo apt-get update
sudo apt-get install -y build-essential cmake git libasound2-dev libx11-dev libxrandr-dev libxi-dev libgl1-mesa-dev libglu1-mesa-dev

if [ ! -d "raylib" ]; then
  echo "2. Clonando el repositorio oficial de Raylib..."
  git clone https://github.com/raysan5/raylib.git
else
  echo "2. El directorio 'raylib' ya existe. Se asumirá que es el repositorio de Raylib."
fi


echo "3. Compilando e instalando Raylib..."
cd raylib
if [ -d "build" ]; then
  echo "3.a. Ya existe el directorio 'build'. Se reutilizará."
else
  mkdir build
fi
cd build
cmake ..
make
sudo make install

cd ../../



PROJECT_DIR="MiProyectoRaylib"
echo "4. Creando directorio de proyecto: $PROJECT_DIR"
if [ -d "$PROJECT_DIR" ]; then
  echo "   El directorio '$PROJECT_DIR' ya existe. Se sobrescribirán los archivos que coincidan."
else
  mkdir "$PROJECT_DIR"
fi

cd "$PROJECT_DIR"


echo "5. Generando el archivo fuente 'main.c' con un ejemplo de Raylib..."
cat > main.c << 'EOF'
#include <raylib.h>

int main(void) {
    const int screenWidth = 800;
    const int screenHeight = 450;

    InitWindow(screenWidth, screenHeight, "Mi Proyecto Raylib");
    SetTargetFPS(60);

    while (!WindowShouldClose()) {
        BeginDrawing();
        ClearBackground(RAYWHITE);
        DrawText("¡Hola, Raylib!", 10, 10, 20, DARKGRAY);
        EndDrawing();
    }

    CloseWindow();
    return 0;
}
EOF


echo "6. Generando el script 'compile.sh' para compilar el proyecto..."
cat > compile.sh << 'EOF'
#!/usr/bin/env bash

gcc -o MiProyecto main.c -lraylib -lm -lpthread -ldl -lrt -lX11

echo "Compilación finalizada. Ejecuta './MiProyecto' para correr el programa."
EOF

chmod +x compile.sh

echo
echo "=========================================="
echo "¡Listo! Raylib se instaló, el proyecto se creó y"
echo "se generó 'compile.sh' dentro de '$PROJECT_DIR'."
echo "Para compilar tu proyecto, entra en '$PROJECT_DIR' y ejecuta:"
echo "    ./compile.sh"
echo "=========================================="
