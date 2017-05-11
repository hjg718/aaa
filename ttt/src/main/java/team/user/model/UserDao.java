package team.user.model;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import team.book.model.BookVo;



@Repository
public interface UserDao {
	public String check(String id);
	public int join(UserVo vo);
	public UserVo getvo(String id);
	public int edit(HashMap<String, Object> map);
	public int secession(String userid);
	public List<RentalVo> rentalInfo(String userid);
	public BookVo rentalBook(int bnum);

}
