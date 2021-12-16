# ``SwiftPDF``

Erstelle PDFs anhand eines deklarativen Ansatzes.

## Overview

Erstelle Inhalte von PDF-Dokumenten durch Verwendung von ``Text`` und Grafiken 
mit Hilfe von ``Shape``s, wie ``Path``, ``RoundedRectangle`` und weiteren Formen.

Durch das automatische Layoutsystem werden inkonsistente Positionierung und Dimensionierung vermieden.
Stacks wie ``HStack`` und ``VStack`` richten ``View``s entlang ihrer Hauptachse aus 
und mit dem ``ZStack`` werden View-Elemente übereinander gestapelt.

Jede ``View`` besitzt eine vielzahl von Modifikatoren,
um der View zum Beispiel einen Abstand zu umliegenden Elementen zu geben, 
eine Umrandung zu zeichen oder der View nur eine maximale Raumgröße zuzuteilen,
wie es mit ``View/padding(_:)-4nkjg``,
``View/border(color:width:)`` und
``View/frame(width:height:alignment:)`` möglich ist.

## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
