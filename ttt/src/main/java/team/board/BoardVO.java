package team.board;

import java.sql.Date;

public class BoardVO {

	private int num; // 글 번호 (pk_)
	private String title; // 글 제목
	private String contents; //글 내용
	private String author; //작성자
	private Date regdate; // 작성 날짜
	private int ref;
	
	
	//------------------------------
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	} 
	
	
	
	
}
