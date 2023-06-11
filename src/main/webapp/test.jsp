<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Show/Hide Elements</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <style>
        /* Add your custom CSS styles here */
        .hidden {
            display: none;
        }
    </style>
</head>
<body>
    <h1>Show/Hide Elements Example</h1>

    <button onclick="toggleElement('content1')">Toggle Content 1</button>
    <div id="content1" class="hidden">
        <h2>Content 1</h2>
        <p>This is the first content section.</p>
    </div>

    <button onclick="toggleElement('content2')">Toggle Content 2</button>
    <div id="content2" class="hidden">
        <h2>Content 2</h2>
        <p>This is the second content section.</p>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleElement(elementId) {
            var element = document.getElementById(elementId);
            if (element.style.display === "none") {
                element.style.display = "block";
            } else {
                element.style.display = "none";
            }
        }
    </script>
</body>
</html>
