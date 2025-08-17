# Comp - Compresor Interactivo

Un compresor de archivos interactivo y fácil de usar con múltiples formatos de compresión.

## 🚀 Instalación Rápida

```bash
curl -fsSL https://raw.githubusercontent.com/jdanielr07/scripts/main/install.sh | bash
```

## 📦 Características

- **Interfaz interactiva** con menús intuitivos
- **Múltiples formatos** de compresión:
  - `tar.gz` - tar + gzip (rápido, universal)
  - `tar.bz2` - tar + bzip2 (buena compresión)
  - `tar.xz` - tar + xz (excelente compresión)
  - `tar.zst` - tar + zstd (rápido y eficiente)
  - `7z` - 7z (muy buena compresión, libre)
  - `zip` - zip (universal, compatible)
- **Configuración persistente** - Elige tu formato favorito una vez
- **Instalación automática** de dependencias
- **Nombres únicos** - Evita sobrescribir archivos existentes
- **Comando corto** - Solo `comp`

## 🎯 Uso

```bash
comp
```

## 🔧 Configuración

El script guarda tu configuración en `~/.comprimir_config`. Puedes cambiar el tipo de compresión desde el menú principal.

## 📋 Requisitos

- **gum** - Se instala automáticamente si no está presente
- **curl** - Para la instalación

## 🛠️ Formatos Soportados

| Formato | Descripción | Instalación Automática |
|---------|-------------|------------------------|
| tar.gz | Universal, rápido | gzip |
| tar.bz2 | Buena compresión | bzip2 |
| tar.xz | Excelente compresión | xz-utils |
| tar.zst | Rápido y eficiente | zstd |
| 7z | Muy buena compresión | p7zip |
| zip | Universal | zip |

## 🎨 Capturas de Pantalla

```
COMPRIMIR CARPETAS
┌─────────────────────────────┐
│ 🔧 Configuración actual: 7z │
└─────────────────────────────┘

¿Qué quieres hacer?
  Comprimir carpeta
  Cambiar configuración
  Salir
```

## 📝 Licencia

MIT License - Libre para uso personal y comercial.

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Abre un issue o envía un pull request.

## 📞 Soporte

Si tienes problemas, abre un issue en GitHub.
