# Publicar noticias desde n8n

n8n envía cada artículo a la web con una petición **POST**. La noticia entra como **pendiente** y
solo se publica cuando un asesor la aprueba en *Panel → Noticias*.

## 1. Clave secreta (obligatoria)
Sin clave, el webhook responde `401` y no guarda nada.

1. Genera una clave: `php -r "echo bin2hex(random_bytes(32));"`
2. Ponla en el `.env` **del servidor**: `N8N_WEBHOOK_TOKEN=la_clave_generada`
3. En el nodo HTTP Request de n8n añade la cabecera:
   `Authorization: Bearer la_clave_generada`  (o bien `X-Webhook-Token: la_clave_generada`)

> Al desplegar este cambio, el flujo actual de n8n dejará de publicar hasta que se complete el
> paso 3. Hazlo antes de subir la web a producción.

## 2. Dirección
- Recomendada: `POST https://selectoasesores.es/api/webhooks/n8n/noticias`
- También funciona (la de siempre): `POST https://selectoasesores.es/noticias/n8n`

## 3. Cuerpo (JSON)
Ejemplo, con la estructura del Flujo 2:

```json
{
  "titulo": "Nueva ayuda para autónomos",
  "fuente": "BOE",
  "url": "https://www.boe.es/...",
  "fecha": "2026-11-03",
  "resumen": "Resumen breve para la tarjeta del blog.",
  "afecta_a": "Autónomos con ingresos bajos",
  "impacto": "Reduce la cuota durante un año",
  "contenido": "Artículo propio, párrafos separados por una línea en blanco.",
  "categoria": "subvenciones",
  "imagen": "https://..."
}
```

| Campo | Obligatorio | Notas |
|---|---|---|
| `titulo` | Sí | Máx. 255 caracteres. Genera la dirección del artículo. |
| `fuente` / `url` / `fecha` | No | Se muestran como «Fuente» al final del artículo. `url` debe ser una URL válida. |
| `resumen` | No | Aparece en la tarjeta y como entradilla. |
| `afecta_a` / `impacto` | No | Aparecen en el recuadro lateral del artículo. |
| `contenido` | No | Cuerpo del artículo (texto, sin HTML). Si falta, se usa el resumen. |
| `categoria` | No | Ver abajo. Si no se reconoce, se usa «Actualidad fiscal». |
| `imagen` | No | URL. Si falta, se usa una imagen por defecto de la categoría. |

### Categorías
Acepta el nombre o la clave: `actualidad-fiscal`, `guias-practicas`, `ecommerce-internacional`,
`subvenciones`. Palabras como «ayudas» se asignan a Subvenciones.

## 4. Respuestas
| Código | Significado |
|---|---|
| `201` | Noticia creada como pendiente. |
| `200` `duplicate` | Ya existía un artículo con ese título. No se modifica ni se despublica. |
| `401` | Falta la clave o es incorrecta. |
| `422` | Datos inválidos; `errors` indica qué campo falla. |

## Derechos de autor
Cada artículo debe ser texto propio que cite la fuente. No copies ni traduzcas el texto de otros
medios: la web enlaza la fuente, pero el contenido que publicas es el campo `contenido`.
