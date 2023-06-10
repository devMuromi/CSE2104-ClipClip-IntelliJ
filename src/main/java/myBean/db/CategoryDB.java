package myBean.db;

import java.awt.image.CropImageFilter;
import java.sql.*;
import java.time.LocalDateTime;
import javax.naming.NamingException;
import myBean.db.DsCon;
import java.util.*;

public class CategoryDB {
    private Connection con;
    private Statement stmt;
    private PreparedStatement pstmt;
    private ResultSet rs;


    public CategoryDB() throws NamingException, SQLException {
        con = DsCon.getConnection();

    }

    public int getCount(int id) throws SQLException {
        String sql = "SELECT id FROM clipart WHERE categoryId=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        int count = 0;
        while(rs.next()) {
            count++;
        }
        rs.close();
        return count;
    }

    public void insertRecord(Category category) throws SQLException {
        String sql = "INSERT INTO category(name) VALUES(?)";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, category.getName());

        pstmt.executeUpdate();
    }

    public Category getRecord(int id) throws SQLException {
        Category category = new Category();
        String sql = "SELECT name FROM category WHERE id=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, id);
        rs = pstmt.executeQuery();
        rs.next();

        category.setId(id);
        category.setName(rs.getString("name"));

        return category;
    }

    public List<Category> getCategoryList() throws SQLException {
        List<Category> categoryList = new ArrayList<Category>();

        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT id, name FROM category");
        while(rs.next()) {
            int id = rs.getInt("id");
            Category category = new Category();
            category.setId(id);
            category.setName(rs.getString("name"));
            category.setClipartCount(getCount(id));
            categoryList.add(category);
        }
        return categoryList;
    }

    public void updateRecord(Category category) throws SQLException {
        String sql = "UPDATE category SET name=? WHERE id=?";
        pstmt = con.prepareStatement(sql);

        pstmt.setString(1, category.getName());
        pstmt.setInt(2, category.getId());

        pstmt.executeUpdate();
    }


    public void deleteRecord(int id) throws SQLException {
        String sql = "DELETE FROM category WHERE id=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, id);
        pstmt.executeUpdate();
    }

    public void close() throws SQLException {
        if(rs != null) rs.close();
        if(stmt != null) stmt.close();
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
}