**README

*INTRODUCTION

This app is the result of a (theodinproject.com assignment)[http://www.theodinproject.com/ruby-on-rails/authentication?ref=lnav]

*DATA STRUCTURE

2 data models:
*users
	*name:string, [not_empty, between 6 .. 20 chars]
	*email:string, [is_valid, not_empty]
	*password_digest:string, [not_empty]
	*member:bool
	has_many posts
*posts
	*title:string, [not_empty]
	*content:string, [not_empty, more then 15 chars]
	belongs_to users