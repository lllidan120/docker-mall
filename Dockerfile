FROM 8.11.1
MAINTAINER mingyu

ENV HOST 0.0.0.0
ENV PORT 8000

EXPOSE 8000

CMD ["npm","dev"]
