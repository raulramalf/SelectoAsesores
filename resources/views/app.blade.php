<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title inertia>{{ config('app.name', 'Selecto Asesores') }}</title>

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="icon" href="/favicon.ico" type="image/x-icon">
        <link href="https://fonts.googleapis.com/css2?family=Instrument+Serif:ital@0;1&family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">

        @routes
        @vite(['resources/js/app.js', "resources/js/Pages/{$page['component']}.vue"])
        @inertiaHead
       <script>
        window.addEventListener('load', function() {
            const logoUrl = '/favicon.ico'; 
            const img = new Image();
            img.src = logoUrl;
            img.crossOrigin = "Anonymous";

            img.onload = function() {
                const canvas = document.createElement('canvas');
                const ctx = canvas.getContext('2d');
                canvas.width = img.width;
                canvas.height = img.height;
                ctx.drawImage(img, 0, 0);

                const pixels = ctx.getImageData(0, 0, canvas.width, canvas.height);
                let minX = canvas.width, minY = canvas.height, maxX = 0, maxY = 0;

                for (let y = 0; y < canvas.height; y++) {
                    for (let x = 0; x < canvas.width; x++) {
                        const alpha = pixels.data[(y * canvas.width + x) * 4 + 3];
                        if (alpha > 0) { 
                            if (x < minX) minX = x;
                            if (y < minY) minY = y;
                            if (x > maxX) maxX = x;
                            if (y > maxY) maxY = y;
                        }
                    }
                }

                const width = (maxX - minX) + 1;
                const height = (maxY - minY) + 1;
                
                const size = Math.max(width, height);
                const croppedCanvas = document.createElement('canvas');
                const croppedCtx = croppedCanvas.getContext('2d');
                
                croppedCanvas.width = size;
                croppedCanvas.height = size;

                const offsetX = (size - width) / 2;
                const offsetY = (size - height) / 2;

                croppedCtx.drawImage(img, minX, minY, width, height, offsetX, offsetY, width, height);

                const link = document.querySelector("link[rel*='icon']") || document.createElement('link');
                link.type = 'image/png'; // Usamos PNG para mantener la transparencia generada
                link.rel = 'shortcut icon';
                link.href = croppedCanvas.toDataURL("image/png");
                document.getElementsByTagName('head')[0].appendChild(link);
            };
        });
    </script>
    </head>
    <body class="font-sans antialiased bg-brand-dark text-white selection:bg-brand-gold selection:text-brand-dark">
        @inertia
    </body>
</html>