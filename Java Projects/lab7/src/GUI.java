
import java.awt.*; //импортирование пакета awt
import java.awt.event.*; //импортирование пакета поддержки событий
public class GUI extends Frame { //объявление класса GUISample
    List list1;
    Choice list2;
    Checkbox checkboxChet;
    Checkbox checkboxNechet;

    public GUI() {
        setLayout(null);
        setSize(370, 340);
        setBackground(Color.white);


        list1 = new List();
        list1.setMultipleMode(true);
        list2 = new Choice();
        checkboxChet = new Checkbox("Выделить четные");
        checkboxNechet = new Checkbox("Выделить нечетные");
        add(list1);
        list1.setBounds(50,50,100, 200);
        add(list2);
        list2.setBounds(200,50,100, 200);
        add(checkboxChet);
        checkboxChet.setBounds(200, 270, 150, 20);
        checkboxChet.addItemListener(new CheckBoxClick());
        add(checkboxNechet);
        checkboxNechet.setBounds(200, 300, 150, 20);
        checkboxNechet.addItemListener(new CheckBoxClick());
        initializeListItems();
        addWindowListener(new WindowClose());
    }

    public void initializeListItems() {
        list1.add("First");
        list1.add("Second");
        list1.add("Third");
        list1.add("Fourth");

    }

    class WindowClose extends WindowAdapter {
        public void windowClosing(WindowEvent we) {
            setVisible(false);
        }
    }

    class CheckBoxClick implements ItemListener {

        @Override
        public void itemStateChanged(ItemEvent e) {
            Checkbox checkbox = (Checkbox) e.getSource();
            int i;
            if(checkbox.equals(checkboxNechet))
                i = 0;
            else if(checkbox.equals(checkboxChet))
                i = 1;
            else
                return;
            for (; i < list1.getItemCount(); i+=2) {
                if (list1.isIndexSelected(i))
                    list1.deselect(i);
                else
                    list1.select(i);
                if(i%2==0) {
                    list2.add(list1.getItem(i));
                }
            }
        }

    }

    public static void main(String args[]) {
        GUI MyFrame = new GUI();
        MyFrame.setVisible(true);
    }
}
