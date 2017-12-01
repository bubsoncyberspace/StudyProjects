<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 25.10.2016
  Time: 2:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Отчёт</title>
    <link href="css/stl.css" rel="stylesheet" type="text/css">
</head>
<body>
<table>
    <tr>
        <th>Категория</th>
        <th>Количество</th>
        <th>Максимальная цена</th>
        <th>Минимальная цена</th>
    </tr>
    <c:forEach var="report" items="${reports}">
        <tr>
            <td>${report.category}</td>
            <td>${report.count}</td>
            <td>${report.maxPrice}</td>
            <td>${report.minPrice}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
