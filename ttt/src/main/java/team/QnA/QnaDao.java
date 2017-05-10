package team.QnA;

import org.springframework.stereotype.Repository;

@Repository
public interface QnaDao {

	public int save(QnaVo vo);
	
	public QnaVo Recent(String userId);
}
