<?php
  ini_set('display_errors', 1);
  error_reporting(E_ALL);

  $host_name = 'db5020305418.hosting-data.io';
  $database = 'dbs15600336';
  $user_name = 'dbu484222';
  $password = 'Apx001esk!';

  $link = new mysqli($host_name, $user_name, $password, $database);

  if ($link->connect_error) {
    die('<p>Verbindung zum MySQL Server fehlgeschlagen: '. $link->connect_error .'</p>');
  } else {
    $result = $link->query("SELECT * FROM pokedex");

    $pokemon = [];

    while($row = $result->fetch_assoc()) {
        $pokemon[] = $row;
    }

    echo json_encode ($pokemon);
  }
?>