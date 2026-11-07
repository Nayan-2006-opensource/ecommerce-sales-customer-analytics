UPDATE ecommerce_analystics.order_reviews
SET review_comment_title = 'title is not available for the review'
WHERE review_comment_title = '';

UPDATE ecommerce_analystics.order_reviews
SET review_comment_message = 'review is not available for this order'
WHERE review_comment_message = '';
