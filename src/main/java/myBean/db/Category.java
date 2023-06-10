package myBean.db;

public class Category
{
    private int id;
    private String name;
    private int clipartCount;

    public Category() {
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public int getClipartCount() { return clipartCount; }

    public void setClipartCount(int clipartCount) { this.clipartCount = clipartCount; }
}

