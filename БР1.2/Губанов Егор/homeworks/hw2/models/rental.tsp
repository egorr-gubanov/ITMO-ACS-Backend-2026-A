import "@typespec/http";

using Http;

enum Role {
  TENANT,
  OWNER,
  ADMIN,
}

enum DealStatus {
  PENDING,
  ACTIVE,
  COMPLETED,
}

model UserPublic {
  id: string;
  role: Role;
  first_name: string;
  last_name: string;
  email: string;
  is_verified: boolean;
  created_at: utcDateTime;
  updated_at: utcDateTime;
}

model RegisterBody {
  email: string;
  password: string;
  first_name: string;
  last_name: string;
  role: Role;
}

model LoginBody {
  email: string;
  password: string;
}

model AuthOk {
  access_token: string;
  token_type: string;
  user: UserPublic;
}

model OwnerShort {
  id: string;
  first_name: string;
  last_name: string;
}

model PropertyTypeOut {
  id: string;
  title: string;
  is_published: boolean;
  created_at: utcDateTime;
  updated_at: utcDateTime;
}

model PropertyShort {
  id: string;
  owner_id: string;
  type_id: string;
  title: string;
  city: string;
  address: string;
  price: float64;
  is_published: boolean;
  created_at: utcDateTime;
  updated_at: utcDateTime;
}

model PhotoOut {
  id: string;
  property_id: string;
  photo_url: string;
  is_main: boolean;
  created_at: utcDateTime;
}

model PropertyDetail {
  id: string;
  owner_id: string;
  type_id: string;
  title: string;
  city: string;
  address: string;
  description: string;
  rental_conditions: string;
  price: float64;
  is_published: boolean;
  created_at: utcDateTime;
  updated_at: utcDateTime;
  photos: PhotoOut[];
  owner: OwnerShort;
}

model PropertyListResponse {
  items: PropertyShort[];
  total: int32;
}

model PropertyListQuery {
  @query
  type_id?: string;

  @query
  city?: string;

  @query
  min_price?: float64;

  @query
  max_price?: float64;

  @query
  page?: int32;

  @query
  page_size?: int32;
}

model PropertyCreateBody {
  type_id: string;
  title: string;
  city: string;
  address: string;
  description: string;
  rental_conditions: string;
  price: float64;
  is_published: boolean;
}

model PropertyUpdateBody {
  type_id?: string;
  title?: string;
  city?: string;
  address?: string;
  description?: string;
  rental_conditions?: string;
  price?: float64;
  is_published?: boolean;
}

model PhotoCreateBody {
  photo_url: string;
  is_main: boolean;
}

model DealOut {
  id: string;
  property_id: string;
  tenant_id: string;
  status: DealStatus;
  start_date: utcDateTime;
  end_date: utcDateTime;
  total_price: float64;
  created_at: utcDateTime;
  updated_at: utcDateTime;
  property?: PropertyShort;
}

model DealCreateBody {
  property_id: string;
  start_date: utcDateTime;
  end_date: utcDateTime;
  total_price?: float64;
}

model DealPatchBody {
  status: DealStatus;
}

model DealListResponse {
  items: DealOut[];
  total: int32;
}

model MessageOut {
  id: string;
  sender_id: string;
  receiver_id: string;
  property_id: string;
  content: string;
  is_read: boolean;
  created_at: utcDateTime;
}

model MessageCreateBody {
  receiver_id: string;
  property_id: string;
  content: string;
}

model MessageListQuery {
  @query
  property_id?: string;

  @query
  page?: int32;

  @query
  page_size?: int32;
}

model MessageListResponse {
  items: MessageOut[];
  total: int32;
}

model HistoryResponse {
  messages: MessageOut[];
  deals: DealOut[];
}

model RentingResponse {
  items: DealOut[];
  total: int32;
}

model OwningPropertyRow {
  property: PropertyShort;
  active_deals: DealOut[];
}

model OwningResponse {
  items: OwningPropertyRow[];
  total: int32;
}
