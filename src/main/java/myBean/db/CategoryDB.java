package myBean.db;

import java.sql.*;
import javax.naming.NamingException;
import myBean.db.DsCon;

public class CategoryDB {
    private Connection con;
    private PreparedStatement pstmt;
    private ResultSet rs;


    public CategoryDB() throws NamingException, SQLException {
        con = DsCon.getConnection();

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


//    public void updateRecord(Clipart art) throws SQLException {
////        String sql = "INSERT INTO clipart(title, user, category_id, password, tags, description, file, create_date, last_update) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
//
//        String sql = "UPDATE clipart SET id=?, name=?, pwd=? WHERE idx=?";
//        pstmt = con.prepareStatement(sql);
//
//        pstmt.setString(1, art.getId());
//        pstmt.setString(2, art.getName());
//        pstmt.setString(3, art.getPwd());
//        pstmt.setInt(4, art.getIdx());
//
//        pstmt.executeUpdate();
//    }



    //4. 지정된 idx에 해당하는 레코드 삭제 deleteRecord() 선언
    //	@param : int
    //	@return : void
    //	@throws : SQLException

//    public void deleteRecord(int idx) throws SQLException {
//        String sql = "DELETE FROM member WHERE idx=?";
//        pstmt = con.prepareStatement(sql);
//        pstmt.setInt(1, idx);
//        pstmt.executeUpdate();
//    }

    //5. open된 모든 연결자 정보를 제거
    //   @param is'nt
    //   @return void
    public void close() throws SQLException {
        if(rs != null) rs.close();
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
}