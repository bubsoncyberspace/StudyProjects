package by.bsuir.bicyclerental.dao.impl;

import by.bsuir.bicyclerental.bean.entity.Category;
import by.bsuir.bicyclerental.bean.entity.Product;
import by.bsuir.bicyclerental.bean.entity.ReportNode;
import by.bsuir.bicyclerental.constants.DBConstant;
import by.bsuir.bicyclerental.constants.ExceptionConstant;
import by.bsuir.bicyclerental.constants.SQLQueryConstant;
import by.bsuir.bicyclerental.dao.BicycleRentalDAO;
import by.bsuir.bicyclerental.dao.exception.DAOException;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO implements BicycleRentalDAO {

	private Connection connection = null;

	public Connection getConnection() throws DAOException{
		try {
			Class.forName(DBConstant.DB_DRIVER);
			connection = DriverManager.getConnection(DBConstant.DB_URL, DBConstant.DB_LOGIN, DBConstant.DB_PASSWORD);

		} catch (ClassNotFoundException e) {

			throw new DAOException(ExceptionConstant.DB_DRIVER_CLASS_ERROR, e);

		} catch (SQLException e) {

			throw new DAOException(ExceptionConstant.DB_CONNECT_ERROR, e);
		}

		return connection;
	}

	@Override
	public void addProduct(Product product) throws DAOException {
		PreparedStatement preparedStatement = null;
		getConnection();
		try{
			preparedStatement = connection.prepareStatement(SQLQueryConstant.INSERT_QUERY);

			preparedStatement.setInt(1, product.getCategory().getId());
			preparedStatement.setString(2, product.getName());
			preparedStatement.setDouble(3, product.getPrice());
			preparedStatement.setString(4, product.getDescription());

			preparedStatement.executeUpdate();
		} catch (SQLException e){
			throw new DAOException(ExceptionConstant.SQL_FAIL, e);
		} finally {
			closeStatement(preparedStatement);
			closeConnection();
		}
	}

	@Override
	public List<Product> findProductsByCategory(Category category) throws DAOException {
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		List<Product> products = new ArrayList<>();
		getConnection();
		try{
			preparedStatement = connection.prepareStatement(SQLQueryConstant.SELECT_BY_Category_QUERY);

			preparedStatement.setInt(1, category.getId());

			resultSet = preparedStatement.executeQuery();

			while (resultSet.next()){
				products.add(createProduct(resultSet));
			}

			return products;
		} catch (SQLException e){
			throw new DAOException(ExceptionConstant.SQL_FAIL, e);
		} finally {
			closeResultSet(resultSet);
			closeStatement(preparedStatement);
			closeConnection();
		}
	}

	@Override
	public void deleteProduct(Product product) throws DAOException {
		PreparedStatement preparedStatement = null;
		getConnection();
		try{
			preparedStatement = connection.prepareStatement(SQLQueryConstant.DELETE_QUERY);

			preparedStatement.setInt(1, product.getId());

			preparedStatement.executeUpdate();
		} catch (SQLException e){
			throw new DAOException(ExceptionConstant.SQL_FAIL, e);
		} finally {
			closeStatement(preparedStatement);
			closeConnection();
		}
	}

	@Override
	public void updateProduct(Product product) throws DAOException {
		PreparedStatement preparedStatement = null;
		getConnection();

		try{
			preparedStatement = connection.prepareStatement(SQLQueryConstant.UPDATE_QUERY);

			preparedStatement.setInt(1, product.getCategory().getId());
			preparedStatement.setString(2, product.getName());
			preparedStatement.setDouble(3, product.getPrice());
			preparedStatement.setString(4, product.getDescription());
			preparedStatement.setInt(5, product.getId());

			preparedStatement.executeUpdate();
		} catch (SQLException e){
			throw new DAOException(ExceptionConstant.SQL_FAIL, e);
		} finally {
			closeStatement(preparedStatement);
			closeConnection();
		}
	}


	@Override
	public List<Product> findAllProducts() throws DAOException {
		Statement statement = null;
		ResultSet resultSet = null;
		List<Product> products = new ArrayList<>();
		getConnection();

		try{
			statement = connection.createStatement();

			resultSet = statement.executeQuery(SQLQueryConstant.SELECT_ALL_QUERY);

			while (resultSet.next()){
				products.add(createProduct(resultSet));
			}

			return products;
		} catch (SQLException e){
			throw new DAOException(ExceptionConstant.SQL_FAIL, e);
		} finally {
			closeResultSet(resultSet);
			closeStatement(statement);
			closeConnection();
		}
	}

	@Override
	public List<ReportNode> makeReport() throws DAOException {
		Statement statement = null;
		ResultSet resultSet = null;
		List<ReportNode> reports = new ArrayList<>();
		getConnection();

		try{
			statement = connection.createStatement();

			resultSet = statement.executeQuery(SQLQueryConstant.MAKE_REPORT_QUERY);

			while (resultSet.next()){
				ReportNode reportNode = new ReportNode();
				reportNode.setCategory(resultSet.getString(1));
				reportNode.setCount(resultSet.getInt(2));
				reportNode.setMaxPrice(resultSet.getDouble(3));
				reportNode.setMinPrice(resultSet.getDouble(4));
				reports.add(reportNode);
			}

			return reports;
		} catch (SQLException e){
			throw new DAOException(ExceptionConstant.SQL_FAIL, e);
		} finally {
			closeResultSet(resultSet);
			closeStatement(statement);
			closeConnection();
		}
	}


	public void closeConnection() throws DAOException{
		try {
			if (connection != null) {
				connection.close();
			}
		} catch (SQLException e) {
		}
	}

	private Product createProduct(ResultSet resultSet) throws SQLException{
		Product product = new Product();
		Category Category = new Category();

		product.setId(resultSet.getInt(1));
		Category.setId(resultSet.getInt(5));
		Category.setName(resultSet.getString(6));
		product.setCategory(Category);
		product.setName(resultSet.getString(2));
		product.setPrice(resultSet.getDouble(3));
		product.setDescription(resultSet.getString(4));

		return product;
	}

	private void closeStatement(Statement statement){
		try {
			if (statement != null) {
				statement.close();
			}
		} catch (SQLException e){
		}
	}

	private void closeResultSet(ResultSet resultSet){
		try {
			if (resultSet != null) {
				resultSet.close();
			}
		} catch (SQLException e){
		}
	}
}
