<%-- Created by IntelliJ IDEA. --%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<html>
  <head>
    <title>Bicycle Rental</title>
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
  </head>
  <body>
  <form action="Controller" method="post">
    <input type="hidden" name="command" value="SEARCH_ALL_PRODUCTS" />
    <input type="submit" value="Показать все товары" /><br />
  </form>
  <hr>
  <form action="Controller" method="post">
    <input type="hidden" name="command" value="MAKE_REPORT" />
    <input type="submit" value="Сделать отчёт" /><br />
  </form>
  <hr>
  <form action="Controller" method="post">
    <input type="hidden" name="command" value="SEARCH_PRODUCTS_BY_CATEGORY" />
    <p>Номер категории:
    <input type="text" name="id_category" /></p>
    <br>
    <input type="submit" value="Показать все товары из категории" /><br />
  </form>
  <hr>
  <form action="Controller" method="post">
    <input type="hidden" name="command" value="DELETE_PRODUCT" />
    <p>Номер товара:
    <input type="text" name="id" /></p>
    <br>
    <input type="submit" value="Удалить товар" /><br />
  </form>
  <hr>
  <form action="Controller" method="post">
    <input type="hidden" name="command" value="EDIT_PRODUCT" />
    <p>Номер товара:
    <input type="text" name="id" /></p>
    <p>Название товара:
    <input type="text" name="name" /></p>
    <p>Цена товара:
    <input type="text" name="price" /></p>
    <p>Описание товара:
    <input type="text" name="description" /></p>
    <p>Номер категории товара:
    <input type="text" name="id_category" /></p>
    <br>
    <input type="submit" value="Изменить товар" /><br />
  </form>
  <hr>
  <form action="Controller" method="post">
    <input type="hidden" name="command" value="ADD_PRODUCT" />
    <p>Название товара:
      <input type="text" name="name" /></p>
    <p>Цена товара:
      <input type="text" name="price" /></p>
    <p>Описание товара:
      <input type="text" name="description" /></p>
    <p>Номер категории товара:
      <input type="text" name="id_category" /></p>
    <br>
    <input type="submit" value="Добавить товар" /><br />
  </form>
  <hr>
  <p>${status}</p>
  </body>
</html>