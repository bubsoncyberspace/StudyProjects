import javax.swing.table.AbstractTableModel;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 * Created by ASUS on 11.10.2016.
 */
public class DoctorModel extends AbstractTableModel {

    private int colNum = 7;
    private int rowNum;

    private String[] colNames =
            {
                    "id", "surname", "name", "lastname",
                    "dateOfBirth", "position", "specialization"
            };

    private ArrayList<String[]> ResultSets;

    public DoctorModel(ResultSet rs)
    {
        ResultSets = new ArrayList<>();
        try
        {
            while(rs.next())
            {
                String[] row =
                        {
                                rs.getString("id"), rs.getString("surname"),
                                rs.getString("name"), rs.getString("lastname"),
                                rs.getString("dateOfBirth"), rs.getString("position"),
                                rs.getString("specialization")
                        };
                ResultSets.add(row);
            }
        }
        catch(Exception e)
        {
            System.out.println("Exception in ElectricalProductModel");
        }
    }

    @Override
    public int getRowCount() {
        return ResultSets.size();
    }

    @Override
    public int getColumnCount() {
        return colNum;
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        String[] row = ResultSets.get(rowIndex);
        return row[columnIndex];
    }

    @Override
    public String getColumnName(int param)
    {
        return colNames[param];
    }
}
