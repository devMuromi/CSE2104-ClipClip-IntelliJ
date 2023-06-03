package myBean.db;

import java.util.Date;

public class Clipart
{
    private int idx;
    private String title;
    private String user;
    private int categoryId;
    private String password;
    private String[] tags;
    private String description;
    private int viewCount;
    private int downloadCount;
    private String file; // 수정
    private Date createDate;
    private Date lastUpdate;

    public Clipart() {
    }

    public int getIdx() {
        return idx;
    }
    public void setIdx(int idx) {this.idx = idx;}

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getUser() {
        return user;
    }
    public void setUser(String user) {
        this.user = user;
    }

    public int getCategoryId() {
        return categoryId;
    }
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public String[] getTags() {
        return tags;
    }
    public void setTags(String[] tags) {
        this.tags = tags;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public int getViewCount() {
        return viewCount;
    }
    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }
    public void incrementViewCount() {
        this.viewCount = this.viewCount+1;
    }

    public int getDownloadCount() {
        return downloadCount;
    }
    public void setDownloadCount(int downloadCount) {
        this.downloadCount = downloadCount;
    }
    public void incrementDownloadCount(){
        this.downloadCount = this.downloadCount+1;
    }

    public String getFile() {
        return file;
    }
    public void setFile(String file) {
        this.file = file;
    }

    public Date getCreateDate() {
        return createDate;
    }
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getLastUpdate() {
        return lastUpdate;
    }
    public void setLastUpdate(Date lastUpdate) {
        this.lastUpdate = lastUpdate;
    }
}

