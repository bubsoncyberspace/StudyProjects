package by.bsuir.bicyclerental.bean.entity;

/**
 * Created by ASUS on 19.10.2016.
 */
public class ReportNode {
    private String category;
    private int count;
    private double maxPrice;
    private double minPrice;

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public double getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(double maxPrice) {
        this.maxPrice = maxPrice;
    }

    public double getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(double minPrice) {
        this.minPrice = minPrice;
    }

    @Override
    public String toString() {
        return "ReportNode{" +
                "category='" + category + '\'' +
                ", count=" + count +
                ", maxPrice=" + maxPrice +
                ", minPrice=" + minPrice +
                '}';
    }
}
