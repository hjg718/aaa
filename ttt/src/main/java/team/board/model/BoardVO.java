package team.board.model;

import java.sql.Date;

public class BoardVO {

	private int num; // �� ��ȣ (pk_)
	private String title; // �� ����
	private String contents; //�� ����
	private String author; //�ۼ���
	private Date regdate; // �ۼ� ��¥
	private int ref;
	private int readCnt; // ��ȸ��
	private int goodcnt; // ��õ��
	private String goodname; //��õ��(��õ �������� ��õ�� ���̵� ����)
	private int goodnum;//��õ�� �۹�ȣ
	private int currpage;
	private int totalpage;
	
	//------------------------------
	public int getNum() {return num;}
	public void setNum(int num) {this.num = num;}
	
	public String getTitle() {return title;}
	public void setTitle(String title) {this.title = title;}
	
	public String getContents() {return contents;}
	public void setContents(String contents) {this.contents = contents;}
	
	public String getAuthor() {return author;}
	public void setAuthor(String author) {this.author = author;}
	
	public Date getRegdate() {return regdate;}
	public void setRegdate(Date regdate) {this.regdate = regdate;}
	
	public int getRef() {return ref;}
	public void setRef(int ref) {this.ref = ref;} 
	
	public int getReadCnt() {return readCnt;}
	public void setReadCnt(int readCnt) {this.readCnt = readCnt;}
	
	public int getGoodcnt() {return goodcnt;}
	public void setGoodcnt(int goodcnt) {this.goodcnt = goodcnt;}
	
	public String getGoodname() {return goodname;}
	public void setGoodname(String goodname) {this.goodname = goodname;}
	
	public int getGoodnum() {return goodnum;}
	public void setGoodnum(int goodnum) {this.goodnum = goodnum;}
	
	public int getCurrpage() {return currpage;}
	public void setCurrpage(int currpage) {this.currpage = currpage;}
	
	public int getTotalpage() {return totalpage;}
	public void setTotalpage(int totalpage) {this.totalpage = totalpage;}
	
	
}
