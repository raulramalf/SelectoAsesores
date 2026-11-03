# Imágenes de la web

La web no incluye fotografías propias todavía. Estos son los huecos que esperan imagen.
Mientras un archivo no exista, la sección simplemente no lo muestra (no hay imágenes rotas).

Criterios: fotografía real, luz natural, sin poses de banco de imágenes, mismo tratamiento
de color en todas. Formato JPG o WebP, máximo ~300 KB por imagen.

| Archivo | Dónde se usa | Medida recomendada | Contenido sugerido |
|---|---|---|---|
| `public/images/about/hero-placeholder.jpg` | Nosotros · fondo de cabecera (se ve muy atenuada) | 1920×900 | Oficina o sala de reuniones |
| `public/images/about/equipo-placeholder.jpg` | Nosotros · bloque Misión y Visión | 1600×800 | El equipo trabajando o en reunión con un cliente |
| `public/videos/hero-placeholder.mp4` | Inicio · vídeo de portada (opcional) | 1920×1080, <8 MB | Oficina, sin audio |

Las cabeceras de Inicio, Blog y la oferta de la portada usan hoy fotos de Unsplash enlazadas
desde `resources/css/home.css`, `resources/css/pages.css`, `resources/js/Pages/Public/Home.vue`
y `Blog.vue`. Se pueden sustituir por archivos propios en `public/images/`.
