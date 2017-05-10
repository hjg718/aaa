package team.QnA;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

@Repository
public interface QnaDao {

	public int save(QnaVo vo);
	
	public QnaVo Recent(String userId);
	
	public ArrayList<QnaVo> List();
	
	public Qna getPage(int page);
}
