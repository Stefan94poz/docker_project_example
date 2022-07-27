import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from '../prisma/prisma.module';
import { UsersModule } from 'src/users/users.module';
import { BooksModule } from 'src/books/books.module';

@Module({
  imports: [UsersModule, BooksModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
