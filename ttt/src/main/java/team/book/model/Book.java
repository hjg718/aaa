package team.book.model;

import java.util.List;

public class Book {
	
	private int page;
	private int tpg;
	private List<BookVo> list;
	
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
	
	
}
