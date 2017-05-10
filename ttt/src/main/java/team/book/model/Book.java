package team.book.model;

import java.util.Date;
import java.util.List;

public class Book {
	
	private int page;
	private int tpg;
	private List<BookVo> list;
	private String rentaluser;
	private Date returndate;
	private BookVo vo;
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getTpg() {
		return tpg;
	}
	public void setTpg(int tpg) {
		this.tpg = tpg;
	}
	public List<BookVo> getList() {
		return list;
	}
	public void setList(List<BookVo> list) {
		this.list = list;
	}
	public String getRentaluser() {
		return rentaluser;
	}
	public void setRentaluser(String rentaluser) {
		this.rentaluser = rentaluser;
	}
	public Date getReturndate() {
		return returndate;
	}
	public void setReturndate(Date returndate) {
		this.returndate = returndate;
	}

	public BookVo getVo() {
		return vo;
	}
	public void setVo(BookVo vo) {
		this.vo = vo;
	}

	
	
}
