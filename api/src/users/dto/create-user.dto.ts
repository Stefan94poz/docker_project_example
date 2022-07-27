import { ApiProperty } from '@nestjs/swagger';

export class createUserDto {
  @ApiProperty()
  name: string;
}
