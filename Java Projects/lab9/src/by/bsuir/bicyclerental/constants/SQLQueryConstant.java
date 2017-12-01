package by.bsuir.bicyclerental.constants;

/**
 * Created by ASUS on 19.10.2016.
 */
public class SQLQueryConstant {
    public final static String INSERT_QUERY = "INSERT INTO `products` " +
            "(`id_category`, `name`, `price`, `description`) " +
            "VALUES (?, ?, ?, ?)";

    public final static String DELETE_QUERY = "DELETE FROM `products` " +
            "WHERE `id_product` = ?";

    public final static String UPDATE_QUERY = "UPDATE `products` " +
            "SET `id_Category` = ? , `name` = ? , `price` = ? , `description` =  ?" +
            "WHERE `id_product` = ? ";

    public final static String SELECT_BY_Category_QUERY = "SELECT `products`.`id_product`, `products`.`name`, " +
            "`products`.`price`, `products`.`description`, `products`.`id_category`, `Catigories`.`name`" +
            " FROM `products` " +
            "INNER JOIN `Catigories` ON `products`.`id_category` = `Catigories`.`id_category` " +
            "WHERE `products`.`id_category` = ?";

    public final static String SELECT_ALL_QUERY = "SELECT `products`.`id_product`, `products`.`name`, " +
            "`products`.`price`, `products`.`description`, `products`.`id_category`, `Catigories`.`name`" +
            " FROM `products` " +
            "INNER JOIN `Catigories` ON `products`.`id_category` = `Catigories`.`id_category` ";

    public final static String MAKE_REPORT_QUERY = "SELECT `catigories`.`name`, COUNT(`products`.`id_product`)," +
            "MAX(`products`.`price`), MIN(`products`.`price`) " +
            "FROM `products` INNER JOIN `catigories` ON `products`.`id_category` = `catigories`.`id_category` " +
            "GROUP BY `products`.`id_category` ";

}
