<?php

$clave = 123456789;

$generarClave = password_hash($clave, PASSWORD_DEFAULT);

echo $generarClave;