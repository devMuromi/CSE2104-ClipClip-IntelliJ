package myBean.db;

import java.sql.*;
import javax.naming.NamingException;
import myBean.db.DsCon;

public class ClipartDB {
    private Connection con;
    private PreparedStatement pstmt;
    private ResultSet rs;


    public ClipartDB() throws NamingException, SQLException {
        con = DsCon.getConnection();

    }

    public void insertRecord(Clipart clipart) throws SQLException {
        String sql = "INSERT INTO clipart(title, user, category_id, password, tags, description, file, create_date, last_update) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";

        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, clipart.getTitle());
        pstmt.setString(2, clipart.getUser());
        pstmt.setInt(3, clipart.getCategoryId());
        pstmt.setString(4, clipart.getPassword());
        pstmt.setString(5, String.join(",", clipart.getTags()));
        pstmt.setString(6, clipart.getDescription());
//        pstmt.setString(7, clipart.getFile());
        java.util.Date createDate = clipart.getCreateDate();
        java.sql.Date sqlCreateDate = new java.sql.Date(createDate.getTime());
        pstmt.setDate(8, sqlCreateDate);

        java.util.Date lastUpdate = clipart.getLastUpdate();
        java.sql.Date sqlLastUpdate = new java.sql.Date(lastUpdate.getTime());
        pstmt.setDate(9, sqlLastUpdate);

        pstmt.executeUpdate();
    }

    public Clipart getRecord(int idx) throws SQLException {
        Clipart clipart = new Clipart();
        String sql = "SELECT title, user, category_id, password, tags, description, view_count, download_count, file, create_date, last_update FROM clipart WHERE idx=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, idx);
        rs = pstmt.executeQuery();
        rs.next();

        clipart.setIdx(idx);
        clipart.setTitle(rs.getString("title"));
        clipart.setUser(rs.getString("user"));
        clipart.setCategoryId(rs.getInt("category_id"));
        clipart.setPassword(rs.getString("password"));
        clipart.setTags(rs.getString("tags").split(","));
        clipart.setDescription(rs.getString("description"));
        clipart.setViewCount(rs.getInt("view_count"));
        clipart.setDownloadCount(rs.getInt("download_count"));
        clipart.setFile(rs.getString("file"));
//        java.sql.Date createDate = rs.getDate("create_date");
//        clipart.setCreateDate(new java.util.Date(createDate.getTime()));
//        java.sql.Date lastUpdate = rs.getDate("last_update");
//        clipart.setLastUpdate(new java.util.Date(lastUpdate.getTime()));

        return clipart;
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