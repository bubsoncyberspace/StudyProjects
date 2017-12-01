<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 25.10.2016
  Time: 20:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Все товары</title>
    <link href="css/stl.css" rel="stylesheet" type="text/css">
</head>
<body>
<table>
    <tr>
        <th>Номер</th>
        <th>Категория</th>
        <th>Имя</th>
        <th>Цена</th>
        <th>Описание</th>
    </tr>
    <c:forEach var="product" items="${products}">
        <tr>
            <td>${product.id}</td>
            <td>${product.category.name}</td>
            <td>${product.name}</td>
            <td>${product.price}</td>
            <td>${product.description}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
