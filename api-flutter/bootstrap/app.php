<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Http\Middleware\HandleCors;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php', // <-- Pastikan baris ini ada
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware) {
        // Daftarkan HandleCors sebagai middleware global
        // Ini akan menambahkan header izin ke SEMUA respons
        $middleware->use([
            HandleCors::class, 
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })->create();